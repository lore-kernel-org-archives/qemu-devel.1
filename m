Received: from eggs.gnu.org ([209.51.188.92]:54470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hCW62-0000MH-1w
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hCW5t-0005v5-4y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:09:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hCW5l-0005LS-0Q
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:09:44 -0400
Date: Fri, 05 Apr 2019 14:09:04 -0700
From: Wei Li <wei.d.li@oracle.com>
Message-ID: <C0F977FC-A960-4FA5-B2DF-BBD9DA664F8A@oracle.com>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
In-Reply-To: <20190401090724.GA643@stefanha-x1.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Thanks Stefan for your quick response!

Hi Paolo,
Could you please send us a link related to the multiqueue feature which you=
 are working on so that we could start getting some details about the featur=
e.

Thanks again,
Wei=20

=EF=BB=BFOn 4/1/19, 3:54 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:

    On Fri, Mar 29, 2019 at 08:16:36AM -0700, Wei Li wrote:
    > Thanks Stefan for your reply and guidance!
    >=20
    > We spent some time on exploring the multiple I/O Threads approach per=
 your feedback. Based on the perf measurement data, we did see some IOPS imp=
rovement for multiple volumes, which is great. :)
    >=20
    > In addition, IOPS for single Volume will still be a bottleneck, it se=
ems like multiqueue block layer feature which Paolo is working on may be abl=
e to help improving the IOPS for single volume.
    >=20
    > @Paolo, @Stefan,=20
    > Would you mind sharing the multiqueue feature code branch with us? So=
 that we could get some rough idea about this feature and maybe start doing =
some exploration?=20
   =20
    Paolo last worked on this code, so he may be able to send you a link.
   =20
    Stefan
   =20
