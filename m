Received: from eggs.gnu.org ([2001:4830:134:3::10]:44232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbZsF-0005Lf-5g
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbZsC-0007rM-4H
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:33:59 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:34246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbZsC-0007rE-0a
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:33:56 -0500
Received: by mail-io0-x242.google.com with SMTP id c80so265567iod.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 13:33:55 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-5-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <274e2803-7956-02d3-4451-23201e056fc4@twiddle.net>
Date: Wed, 8 Feb 2017 13:33:48 -0800
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-5-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/16] target-m68k: define ext_opsize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 02/06/2017 04:59 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
