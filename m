Received: from eggs.gnu.org ([2001:4830:134:3::10]:60147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCQgI-00034o-Dq
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCQgC-0002Gz-U2
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:50:44 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:55215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gCQgC-0002Ci-EL
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:50:40 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181016100918.21030-9-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
	<20181016100918.21030-9-berrange@redhat.com>
Date: Tue, 16 Oct 2018 16:50:37 +0200
Message-ID: <w5136t6ymgy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/8] crypto: add testing for unaligned
 buffers with XTS cipher mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue 16 Oct 2018 12:09:18 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> Validate that the XTS cipher mode will correctly operate with plain
> text, cipher text and IV buffers that are not 64-bit aligned.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Nice :)

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
