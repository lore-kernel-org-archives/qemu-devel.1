Received: from eggs.gnu.org ([2001:4830:134:3::10]:55782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1W1A-00045D-LG
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1W17-0008PM-J7
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:42:24 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:25171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1d1W17-0008O0-By
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:42:21 -0400
Date: Fri, 21 Apr 2017 12:42:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170421091632.30900-10-kraxel@redhat.com>
Message-ID: <alpine.BSF.2.20.1704211236100.58688@zero.eik.bme.hu>
References: <20170421091632.30900-1-kraxel@redhat.com>
	<20170421091632.30900-10-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 9/9] sm501: make display updates thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 21 Apr 2017, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> hw/display/sm501.c | 23 ++++++-----------------
> 1 file changed, 6 insertions(+), 17 deletions(-)

Hold on with this please too. I have a series pending that changes this.

Regards,
BALATON Zoltan
