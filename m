Received: from eggs.gnu.org ([2001:4830:134:3::10]:41730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d7iX1-0005wP-T2
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d7iWy-0001Nl-Oz
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:16:55 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:41106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1d7iWy-0001NS-GH
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:16:52 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170418135726.28022-7-stefanha@redhat.com>
References: <20170418135726.28022-1-stefanha@redhat.com>
	<20170418135726.28022-7-stefanha@redhat.com>
Date: Mon, 08 May 2017 15:16:51 +0200
Message-ID: <w51bmr332v0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 6/9] qcow2: add bdrv_measure() support
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

On Tue 18 Apr 2017 03:57:23 PM CEST, Stefan Hajnoczi wrote:
> Use qcow2_calc_prealloc_size() to get the required file size.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

(I also think that I had already reviewed this one)

Berto
