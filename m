Received: from eggs.gnu.org ([2001:4830:134:3::10]:48007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fbeE2-0007p3-Ki
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 23:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fbeDz-0001UU-Oq
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 23:49:34 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fbeDz-0001TC-JU
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 23:49:31 -0400
Received: by mail-pl0-x242.google.com with SMTP id b1-v6so3669151pls.5
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 20:49:31 -0700 (PDT)
References: <20180706155127.7483-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f7cff7e8-1783-1eeb-151f-7f1a02fb1ca3@linaro.org>
Date: Fri, 6 Jul 2018 20:49:26 -0700
MIME-Version: 1.0
In-Reply-To: <20180706155127.7483-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/3] Sanitize linux-user stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, qemu-devel@nongnu.org

On 07/06/2018 08:51 AM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (3):
>   linux-user: Do not report "Unsupported syscall" by default
>   linux-user: Do not report "syscall not implemented" by default
>   linux-user: Report error message on stderr, rather than stdout

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
