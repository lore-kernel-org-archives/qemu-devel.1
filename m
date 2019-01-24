Received: from eggs.gnu.org ([209.51.188.92]:57900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmbbL-0003hF-LF
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmbbK-0007CP-V7
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:47:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmbbK-00079E-Pm
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:47:10 -0500
Date: Thu, 24 Jan 2019 10:47:04 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124094704.dwjg2wbbe5z37ujw@sirius.home.kraxel.org>
References: <20190123214555.12712-1-relkochta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123214555.12712-1-relkochta@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/1] input-linux: customizable grab toggle
 keys v5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ryan El Kochta <relkochta@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Jan 23, 2019 at 04:45:54PM -0500, Ryan El Kochta wrote:
> This patch adds a new option to the input-linux object:
> 
> grab-toggle=[key-combo]

Other way around: commit message describing the patch goes to the patch
(1/1), the series description (and changes to previous revisions if any)
go to the cover letter (0/1).

Picked up the patch, copied over the description from the cover letter.

thanks,
  Gerd
