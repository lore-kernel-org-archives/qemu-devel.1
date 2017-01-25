Received: from eggs.gnu.org ([2001:4830:134:3::10]:55142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cWV4W-0005qE-Qt
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cWV4S-0002TQ-AO
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:25:40 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cWV4S-0002Sf-1E
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:25:36 -0500
Received: by mail-qt0-x244.google.com with SMTP id w20so636338qtb.1
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 13:25:34 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170125203852.19254-1-laurent@vivier.eu>
	<20170125203852.19254-2-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ad0ded3c-ee6d-f673-9176-fe0f69245bdf@twiddle.net>
Date: Wed, 25 Jan 2017 13:25:30 -0800
MIME-Version: 1.0
In-Reply-To: <20170125203852.19254-2-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: add hppa magic numbers in
 qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 01/25/2017 12:38 PM, Laurent Vivier wrote:
> As we have now a linux-user HPPA target, we can add it to the list of
> supported targets in qemu-binfmt-conf.sh
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  scripts/qemu-binfmt-conf.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
