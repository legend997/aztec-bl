import styled from 'styled-components';
import { Text, TextProps } from './text';

const TextButtonRoot = styled(Text)`
  cursor: pointer;
`;

export const TextButton: React.FunctionComponent<TextProps> = props => <TextButtonRoot {...props} italic />;