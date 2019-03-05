Received: from eggs.gnu.org ([209.51.188.92]:59414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LG0-0004ct-Uz
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LG0-0004Ic-8b
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:04 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LG0-0004IX-1u
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:04 -0500
Received: by mail-pg1-x542.google.com with SMTP id i130so6948979pgd.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:22:03 -0800 (PST)
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <62357c0a-7341-ee37-8ded-9c6ca95351b1@linaro.org>
Date: Tue, 5 Mar 2019 14:40:42 -0800
MIME-Version: 1.0
In-Reply-To: <20190305172139.32662-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/12] docs: Convert memory.txt to rst
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 3/5/19 9:21 AM, Peter Maydell wrote:
> Convert the memory API documentation from plain text
> to restructured text format.
> 
> This is a very minimal conversion: all I had to change
> was to mark up the ASCII art parts as Sphinx expects
> for 'literal blocks', and fix up the bulleted lists
> (Sphinx expects no leading space before the bullet, and
> wants a blank line before after any list).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: 20190228145624.24885-3-peter.maydell@linaro.org
> ---
>  docs/devel/{memory.txt => memory.rst} | 128 ++++++++++++++------------
>  1 file changed, 70 insertions(+), 58 deletions(-)
>  rename docs/devel/{memory.txt => memory.rst} (85%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
