Received: from eggs.gnu.org ([2001:4830:134:3::10]:45386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dqMH4-0003SY-6G
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dqMGz-0005D6-8t
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:36:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dqMGz-0005CO-0U
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:36:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v88GXe5L117012
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 12:36:51 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cuvpdr1m5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 12:36:50 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 10:36:50 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <3cd1d667-e29a-d182-54ef-f8676ca3d81c@amsat.org>
References: <20170830215523.25278-1-f4bug@amsat.org>
	<20170830215523.25278-7-f4bug@amsat.org>
	<3cd1d667-e29a-d182-54ef-f8676ca3d81c@amsat.org>
Date: Fri, 08 Sep 2017 11:36:39 -0500
Message-Id: <150488859944.2366.9236675440483069288@loki>
Subject: Re: [Qemu-devel] [PATCH v2 06/17] MAINTAINERS: add missing Guest
 Agent entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Tomoki Sekiyama <tomoki.sekiyama.qu@hitachi.com>
Cc: qemu-devel@nongnu.org

Quoting Philippe Mathieu-Daud=C3=A9 (2017-09-08 08:04:45)
> ping?
> =

> Michael, you told me this looks OK on IRC, can I respin with your Acked-b=
y?

Sure:

Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> =

> On 08/30/2017 06:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >   MAINTAINERS | 4 ++++
> >   1 file changed, 4 insertions(+)
> > =

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aa185c1edd..f4e07173c8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1434,6 +1434,10 @@ QEMU Guest Agent
> >   M: Michael Roth <mdroth@linux.vnet.ibm.com>
> >   S: Maintained
> >   F: qga/
> > +F: qemu-ga.texi
> > +F: scripts/qemu-guest-agent/
> =

> I'm not sure you want to maintain this one...

That's fine for now. Thanks!

> =

> > +F: tests/test-qga.c
> > +F: docs/interop/qemu-ga-ref.texi
> >   T: git git://github.com/mdroth/qemu.git qga
> >   =

> >   QOM
> > =

>=20
