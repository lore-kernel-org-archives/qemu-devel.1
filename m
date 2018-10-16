Received: from eggs.gnu.org ([2001:4830:134:3::10]:44512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCOjG-0007DJ-5B
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCOjA-0000Aq-Ez
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:45:42 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:37004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gCOj7-00083C-7K
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:45:35 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181016100918.21030-4-berrange@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
	<20181016100918.21030-4-berrange@redhat.com>
Date: Tue, 16 Oct 2018 14:45:11 +0200
Message-ID: <w51h8hmysa0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/8] crypto: introduce a xts_uint128
 data type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue 16 Oct 2018 12:09:13 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> The new type is designed to allow use of 64-bit arithmetic instead
> of operating 1-byte at a time. The following patches will use this to
> improve performance.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
