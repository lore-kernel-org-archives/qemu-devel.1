Received: from eggs.gnu.org ([2001:4830:134:3::10]:47845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ctZIW-0005eC-OV
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ctZIR-0004NI-TZ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:35:28 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:44910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1ctZIR-0004Mb-HR
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:35:23 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170322111608.31230-4-stefanha@redhat.com>
References: <20170322111608.31230-1-stefanha@redhat.com>
	<20170322111608.31230-4-stefanha@redhat.com>
Date: Thu, 30 Mar 2017 14:35:20 +0200
Message-ID: <w51y3vnuelz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/8] qcow2: extract preallocation
 calculation function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow <jsnow@redhat.com>

On Wed 22 Mar 2017 12:16:03 PM CET, Stefan Hajnoczi wrote:
> Calculating the preallocated image size will be needed to implement
> .bdrv_measure().  Extract the code out into a separate function.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
