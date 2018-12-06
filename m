Received: from eggs.gnu.org ([2001:4830:134:3::10]:58631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUxFP-0006b9-7m
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUxFL-0007bV-3P
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:15:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28803
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gUxFK-0007at-RP
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:15:31 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB6H9kEj133266
	for <qemu-devel@nongnu.org>; Thu, 6 Dec 2018 12:15:28 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p76sr40k7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 12:15:28 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 6 Dec 2018 17:15:27 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181206165047.GT29540@redhat.com>
References: <20181128153526.10948-1-berrange@redhat.com>
	<165bc19e-8ed2-8979-aea7-0f6031fc6df2@redhat.com>
	<20181206165047.GT29540@redhat.com>
Date: Thu, 06 Dec 2018 11:15:19 -0600
Message-Id: <154411651930.28165.5754119001430373065@sif>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Document how to test the site
 with jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org, raimue@macports.org, Yu Ning <yu.ning@intel.com>

Quoting Daniel P. Berrang=C3=A9 (2018-12-06 10:50:47)
> Copying Michael Roth as the only remaining non-Red Hat contributor
> we still need approval from

No objections from my end.

> =

> On Wed, Nov 28, 2018 at 05:44:09PM +0100, Paolo Bonzini wrote:
> > On 28/11/18 16:35, Daniel P. Berrang=C3=A9 wrote:
> > > Add a README file that tells people this is a jekyll based static
> > > website, and shows people how to run jekyll for testing purposes.
> > > =

> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > ---
> > > =

> > > NB, we should really mention a license in the README too, but I don't
> > > see info about what license we consider qemu-web to be covered by...
> > =

> >     47        Paolo Bonzini <pbonzini@redhat.com>
> >     44        Michael Roth <mdroth@linux.vnet.ibm.com>
> >     13        Thomas Huth <thuth@redhat.com>
> >      3        Eric Blake <eblake@redhat.com>
> >      2        Daniel P. Berrange <berrange@redhat.com>
> >      2        Jeff Cody <jcody@redhat.com>
> >      1        Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >      1        Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >      1        Fam Zheng <famz@redhat.com>
> >      1        Rainer M=C3=BCller <raimue@macports.org>
> >      1        Stefan Hajnoczi <stefanha@gmail.com>
> >      1        Yu Ning <yu.ning@intel.com>
> > =

> > Anybody (especially non-RH people) disagrees with dual-license CC-BY-SA
> > 4.0 and GPLv2+?  (So that we can copy from blog posts to manuals)?
> > =

> > Paolo
> =

> Regards,
> Daniel
> -- =

> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20
