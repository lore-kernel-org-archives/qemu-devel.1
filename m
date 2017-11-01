Received: from eggs.gnu.org ([2001:4830:134:3::10]:36262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e9qUr-0002l8-Fb
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e9qUo-0003j0-94
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e9qUo-0003id-2B
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:43:42 -0400
Message-ID: <1509533019.3856.9.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 01 Nov 2017 11:43:39 +0100
In-Reply-To: <20171023210803.20998-6-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-6-makovick@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] sdl2 uses surface relative coordinates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>, qemu-devel@nongnu.org

Why?

Also I think this breaks the pointer in case window size doesn't match
surface size.

cheers,
  Gerd
