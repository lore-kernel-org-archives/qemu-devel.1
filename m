Received: from eggs.gnu.org ([2001:4830:134:3::10]:36375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIFNA-0001Os-3d
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIFN6-0000xP-UP
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:26:48 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:43896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIFN6-0000wz-My
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:26:44 -0400
Received: by mail-pg0-x242.google.com with SMTP id p8-v6so2108613pgq.10
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:26:44 -0700 (PDT)
References: <20180513085032.27773-1-sw@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd15aac6-a371-3b93-4ecb-27ff389c43ad@linaro.org>
Date: Mon, 14 May 2018 08:26:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180513085032.27773-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Use strings command from cross
 development tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Mike Frysinger <vapier@gentoo.org>, QEMU Developer <qemu-devel@nongnu.org>

On 05/13/2018 01:50 AM, Stefan Weil wrote:
> This fixes cross builds for the (rare) case where cross binutils
> but no native binutils are installed.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  configure | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
