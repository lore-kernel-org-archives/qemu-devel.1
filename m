Received: from eggs.gnu.org ([209.51.188.92]:39813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggtnZ-0001Ie-Jp
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggtnQ-00026S-1V
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:00:13 -0500
Date: Tue, 8 Jan 2019 16:59:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190108155952.GI11492@linux.fritz.box>
References: <20190105084243.9524-1-npes87184@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105084243.9524-1-npes87184@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add test case for dmg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Am 05.01.2019 um 09:42 hat yuchenlin geschrieben:
> Recently, some bugs in dmg file have been fixed. To prevent reading dmg
> is broken someday in the future, add a simple test which ensures the
> conversion from dmg to raw should not hang or face any I/O error.
> 
> Signed-off-by: yuchenlin <npes87184@gmail.com>

Thanks, applied to the block branch.

Kevin
