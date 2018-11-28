Received: from eggs.gnu.org ([2001:4830:134:3::10]:37230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRwIB-0006oA-7K
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRwI8-000268-3L
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:37:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRwI7-00022t-IS
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:37:55 -0500
Date: Wed, 28 Nov 2018 10:37:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181128093753.6ssuq7dh7zqv3g6d@sirius.home.kraxel.org>
References: <20181128082243.29841-1-fziglio@redhat.com>
	<20181128082243.29841-2-fziglio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128082243.29841-2-fziglio@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] spice: Bump required spice-server
 version to 0.12.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Wed, Nov 28, 2018 at 08:22:43AM +0000, Frediano Ziglio wrote:
> Version 0.12.6 was released on 12th June 2015.

That patch should be first, can you reorder them please?

thanks,
  Gerd

PS: Tried to just reverse ordering when queuing up, but #2 doesn't apply
    to master, seems there is some dependency ...
