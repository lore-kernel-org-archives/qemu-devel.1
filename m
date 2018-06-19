Received: from eggs.gnu.org ([2001:4830:134:3::10]:47449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fVBGg-0002n6-1I
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fVBGc-0001gi-UQ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:41:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fVBGc-0001ga-PU
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:41:30 -0400
Date: Tue, 19 Jun 2018 15:41:21 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20180619074121.GC22275@wei-ubt>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<43058759-28c7-9144-27f3-a16475281973@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43058759-28c7-9144-27f3-a16475281973@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 0/8] packed ring virtio-net userspace
 backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tiwei.bie@intel.com, mst@redhat.com, jfreimann@redhat.com

On Wed, Jun 06, 2018 at 11:49:22AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B406=E6=9C=8806=E6=97=A5 03:07, wexu@redhat.com wrote:
> >From: Wei Xu<wexu@redhat.com>
> >
> >Todo:
> >- address Rx slow performance
> >- event index interrupt suppression test
>=20
> And there's something more need to test:
>=20
> - vIOMMU support
> - migration

OK, I will test it and put it to next version.

>=20
> Thanks
