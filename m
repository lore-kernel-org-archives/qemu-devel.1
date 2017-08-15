Received: from eggs.gnu.org ([2001:4830:134:3::10]:58183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhT7w-0000ep-N0
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhT7s-0006P2-PP
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dhT7s-0006Mx-IH
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:06:44 -0400
Date: Tue, 15 Aug 2017 07:06:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170815070625-mutt-send-email-mst@kernel.org>
References: <20170814084838.12233-1-wei.yang@ucloud.cn>
	<20170814185545-mutt-send-email-mst@kernel.org>
	<59925A94.4070502@ucloud.cn>
	<20170815053445-mutt-send-email-mst@kernel.org>
	<59926083.4030708@ucloud.cn>
	<20170815054903-mutt-send-email-mst@kernel.org>
	<59927039.9000700@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59927039.9000700@ucloud.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] bios-tables-test: delete a assert about
 block name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wyang <wei.yang@ucloud.cn>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org

On Tue, Aug 15, 2017 at 11:53:29AM +0800, wyang wrote:
> Seems the only place, which needs to be fixed, is to replace sizeof wit=
h
> strlen.  Just like what you said, it is not fault but just refinement.
> If you need it, I am glad to send patch to fix it.
>=20
> Wei

Sure.

> --=20
> Wei Yang(=E6=9D=A8=E4=BC=9F)
> Mobile: +86-13436682065
> Email: wei.yang@ucloud.cn
>=20
