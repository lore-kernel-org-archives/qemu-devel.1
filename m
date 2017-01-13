Received: from eggs.gnu.org ([2001:4830:134:3::10]:37457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS6AC-000067-7N
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS6A8-0001Fm-1L
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:01:17 -0500
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:36654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS6A7-0001Fa-T4
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:01:15 -0500
Received: by mail-yb0-x242.google.com with SMTP id l23so2049672ybj.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 10:01:13 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
	<1484311923-28637-5-git-send-email-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <da8a7275-8539-1378-6051-4b2bc4e2eebd@twiddle.net>
Date: Fri, 13 Jan 2017 10:01:10 -0800
MIME-Version: 1.0
In-Reply-To: <1484311923-28637-5-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target-m68k: CAS doesn't need
 aligned access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/13/2017 04:52 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 1 -
>  1 file changed, 1 deletion(-)

Huh.  Wow.  Ok.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
