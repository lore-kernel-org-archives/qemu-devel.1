Received: from eggs.gnu.org ([2001:4830:134:3::10]:43501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cWUSF-0003ms-Rt
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cWUSB-0001uU-CI
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:46:07 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:58036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1cWUSB-0001se-57
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:46:03 -0500
References: <20170125203852.19254-1-laurent@vivier.eu>
	<20170125203852.19254-3-laurent@vivier.eu>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <c7cc5504-ce68-04f8-e24d-0e8c4efc7996@physik.fu-berlin.de>
Date: Wed, 25 Jan 2017 21:45:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170125203852.19254-3-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: fix "apt-get update" on
 linux-user hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Helge Deller <deller@gmx.de>

On 01/25/2017 09:38 PM, Laurent Vivier wrote:
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

CC'ing Helge Deller so he can verify this as well.

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
