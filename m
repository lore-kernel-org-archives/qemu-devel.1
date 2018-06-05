Received: from eggs.gnu.org ([2001:4830:134:3::10]:35562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQEhE-0004GN-8s
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQEhB-0001OB-4E
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:20:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fQEhA-0001Nk-W8
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:20:29 -0400
Date: Tue, 5 Jun 2018 19:20:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605191941-mutt-send-email-mst@kernel.org>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<53c37321-52d2-732c-19fb-8f6a9542c714@gmail.com>
	<20180605132948.GH32286@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180605132948.GH32286@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, ehabkost@redhat.com

On Tue, Jun 05, 2018 at 02:29:48PM +0100, Daniel P. Berrang=E9 wrote:
> Existing domains wasn't the case I was concerned about. Consider you ha=
ve
> libvirt 4.4.0 intsalled and you deploy a *new* domain from a prebuilt
> disk image "foo".

I see. How about q35 as default for new domains only?

--=20
MST
