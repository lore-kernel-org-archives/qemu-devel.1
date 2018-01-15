Received: from eggs.gnu.org ([2001:4830:134:3::10]:39902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ebDqd-0001Cz-8E
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 18:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ebDqc-00022f-BH
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 18:07:23 -0500
References: <20180106153730.30313-1-hpoussin@reactos.org>
	<20180106153730.30313-2-hpoussin@reactos.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <f9c54d01-3fed-8dbe-9d8c-007414a85917@redhat.com>
Date: Mon, 15 Jan 2018 18:07:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180106153730.30313-2-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/16] fdc: move object structures to
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>



On 01/06/2018 10:37 AM, Herv=C3=A9 Poussineau wrote:
> We are now able to embed floppy controllers in another object.
>=20
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Hmm, if it's necessary to have the entire state...

I'll give you the benefit of the doubt because I don't really want to
construct something "better" :)

Acked-by: John Snow <jsnow@redhat.com>
