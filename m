Received: from eggs.gnu.org ([2001:4830:134:3::10]:47341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8qGq-0003XH-7c
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 13:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8q8S-0008Kf-Mx
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 13:13:03 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8q8L-0006ZW-CO
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 13:12:57 -0400
Received: by mail-pg1-x542.google.com with SMTP id v133-v6so6072884pgb.2
	for <qemu-devel@nongnu.org>; Sat, 06 Oct 2018 10:12:52 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f4f7c8eb-50f6-b399-b5c0-941e28b69a85@linaro.org>
Date: Sat, 6 Oct 2018 10:12:48 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 03/21] linux-user: add -dfilter
 progtext shortcut
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu

On 10/5/18 8:48 AM, Alex Bennée wrote:
> When debugging you often don't care about the libraries but just the
> code in the testcase. Rather than make the user build this by hand
> offer a shortcut.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/main.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
