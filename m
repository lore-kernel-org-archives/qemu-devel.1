Received: from eggs.gnu.org ([2001:4830:134:3::10]:33832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gACvq-0002u2-Rq
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gACvn-00042n-IK
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:45:38 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:32797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gACvm-00041L-Eh
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:45:35 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181009125541.24455-2-berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-2-berrange@redhat.com>
Date: Wed, 10 Oct 2018 13:45:31 +0200
Message-ID: <w51in2anhyc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] crypto: expand algorithm coverage for
 cipher benchmark
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue 09 Oct 2018 02:55:36 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> Add testing coverage for AES with XTS, ECB and CTR modes
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
