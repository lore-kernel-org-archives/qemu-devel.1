Received: from eggs.gnu.org ([2001:4830:134:3::10]:42537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWJ4O-00071H-4u
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 05:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWJ4K-000334-T1
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 05:45:47 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181207161351.4380-5-vsementsov@virtuozzo.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
	<20181207161351.4380-5-vsementsov@virtuozzo.com>
Date: Mon, 10 Dec 2018 11:45:39 +0100
Message-ID: <w51a7ldlkx8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] crypto/block: introduce
 qcrypto_block_*crypt_helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Fri 07 Dec 2018 05:13:50 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> Introduce QCryptoBlock-based functions and use them where possible.
> This is needed to implement thread-safe encrypt/decrypt operations.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
