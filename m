Received: from eggs.gnu.org ([2001:4830:134:3::10]:34129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e3lmh-0004kJ-4s
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e3lme-0008SA-1Q
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:29:03 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:54240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e3lmd-0008Rh-Pk
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:28:59 -0400
Received: by mail-pg0-x22f.google.com with SMTP id s2so4928833pge.10
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 09:28:59 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f7381a57-4028-ab03-3858-0e984288fcd6@linaro.org>
Date: Sun, 15 Oct 2017 09:28:56 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 12/30] target/arm/translate-a64.c:
 handle_3same_64 comment fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> We do implement all the opcodes.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/translate-a64.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
