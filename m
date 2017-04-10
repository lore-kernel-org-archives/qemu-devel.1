Received: from eggs.gnu.org ([2001:4830:134:3::10]:58695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxakg-0006Y0-14
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxakc-0006Jr-3p
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:57:10 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:38984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1cxakb-0006Iw-Ns
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:57:06 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170405151148.16363-7-stefanha@redhat.com>
References: <20170405151148.16363-1-stefanha@redhat.com>
	<20170405151148.16363-7-stefanha@redhat.com>
Date: Mon, 10 Apr 2017 16:57:02 +0200
Message-ID: <w51h91we2f5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 6/9] qcow2: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Wed 05 Apr 2017 05:11:45 PM CEST, Stefan Hajnoczi wrote:
> Use qcow2_calc_prealloc_size() to get the required file size.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
