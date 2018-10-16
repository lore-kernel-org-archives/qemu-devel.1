Received: from eggs.gnu.org ([2001:4830:134:3::10]:54918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCQR4-00047k-1r
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCQQy-0007Ao-Un
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:35:01 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:53164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gCQQy-00073K-GW
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:34:56 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181016100918.21030-8-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
	<20181016100918.21030-8-berrange@redhat.com>
Date: Tue, 16 Oct 2018 16:34:47 +0200
Message-ID: <w515zy2yn7c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/8] crypto: refactor XTS cipher mode
 test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue 16 Oct 2018 12:09:17 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> The current XTS test overloads two different tests in a single function
> making the code a little hard to follow. Split it into distinct test
> cases.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
