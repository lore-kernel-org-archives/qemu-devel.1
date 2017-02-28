Received: from eggs.gnu.org ([2001:4830:134:3::10]:34846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cimS4-0002kP-Tq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cimS1-0004r2-Na
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:24:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cimS1-0004qb-Hg
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:24:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EF9F61BB5
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 18:24:41 +0000 (UTC)
Message-ID: <1488306274.26614.41.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 28 Feb 2017 19:24:34 +0100
In-Reply-To: <658a0501-0696-b9d9-2cfd-169277a85c1a@redhat.com>
References: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
	<658a0501-0696-b9d9-2cfd-169277a85c1a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 0/1] seabios: update to 1.10.2 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org

On Di, 2017-02-28 at 11:48 -0500, John Snow wrote:
>=20
> On 02/28/2017 04:06 AM, Gerd Hoffmann wrote:
> >   Hi,
> >=20
> > Here comes the seabios update for qemu 2.9,
> > the just tagged 1.10.2 release.
> >=20
> > Our seabios.git mirror @ qemu.org seems to not sync properly.  The
> > commit isn't there even though it was pushed a few days ago already
> > (only the tag was pushed today).  John, can you have a look please?
> > master branch, *-stable branches and all tags should be mirrored.
> >=20
>=20
> http://git.qemu-project.org/?p=3Dseabios.git;a=3Dlog
>=20
> Looks like the patch I wanted to be there is in there. Are you
> referencing Ladi's commit? It looks like it's there just fine.

Commits from February are missing.  And this one ...

http://git.qemu-project.org/?p=3Dseabios.git;a=3Dshortlog;h=3Drefs/heads/1.=
10-stable

... is outdated too.

cheers,
  Gerd
