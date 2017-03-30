Received: from eggs.gnu.org ([2001:4830:134:3::10]:54594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ctZhw-000603-Kk
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ctZht-0007rs-J9
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:01:44 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:46626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1ctZht-0007py-5w
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:01:41 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170322111608.31230-5-stefanha@redhat.com>
References: <20170322111608.31230-1-stefanha@redhat.com>
	<20170322111608.31230-5-stefanha@redhat.com>
Date: Thu, 30 Mar 2017 15:01:37 +0200
Message-ID: <w51vaqqvrym.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/8] qcow2: extract image creation
 option parsing
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

On Wed 22 Mar 2017 12:16:04 PM CET, Stefan Hajnoczi wrote:
> The image creation options parsed by qcow2_create() are also needed to
> implement .bdrv_measure().  Extract the parsing code, including input
> validation.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
