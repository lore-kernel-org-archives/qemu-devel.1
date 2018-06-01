Received: from eggs.gnu.org ([2001:4830:134:3::10]:33518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOgiN-0002sK-Pb
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOgiM-0002LV-Do
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:51:19 -0400
Date: Fri, 1 Jun 2018 17:51:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180601095105.GC21919@lemon.usersys.redhat.com>
References: <20180601062849.28641-1-famz@redhat.com>
	<152783551554.348.11775495549488216762@d39dc562802a>
	<20180601093709.GD8687@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601093709.GD8687@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/11] qemu-img convert with copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, pl@kamp.de, f4bug@amsat.org, mreitz@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, alex.bennee@linaro.org

On Fri, 06/01 10:37, Stefan Hajnoczi wrote:
> On Thu, May 31, 2018 at 11:45:17PM -0700, no-reply@patchew.org wrote:
> > /var/tmp/patchew-tester-tmp-2l7s8dte/src/block/iscsi.c: In function =E2=
=80=98iscsi_populate_target_desc=E2=80=99:
> > /var/tmp/patchew-tester-tmp-2l7s8dte/src/block/iscsi.c:2242:15: error=
: =E2=80=98IDENT_DESCR_TGT_DESCR=E2=80=99 undeclared (first use in this f=
unction); did you mean =E2=80=98IDENT_DESCR_TGT_DESCR_SIZE=E2=80=99?
> >      desc[0] =3D IDENT_DESCR_TGT_DESCR;
> >                ^~~~~~~~~~~~~~~~~~~~~
> >                IDENT_DESCR_TGT_DESCR_SIZE
> > /var/tmp/patchew-tester-tmp-2l7s8dte/src/block/iscsi.c:2242:15: note:=
 each undeclared identifier is reported only once for each function it ap=
pears in
>=20
> Fam, is this failure expected?

Nope. See my other reply (v9 posted).

Fam
