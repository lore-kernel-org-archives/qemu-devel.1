Received: from eggs.gnu.org ([2001:4830:134:3::10]:40985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQe2w-0001jN-OB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQe2t-0000jt-Iz
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:24:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQe2t-0000j9-DP
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:24:35 -0400
Date: Wed, 6 Jun 2018 16:24:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606192429.GV7451@localhost.localdomain>
References: <20180530200334.24179-1-f4bug@amsat.org>
	<22ca41bb-9f8b-e8bb-e676-b5c96f3f9add@redhat.com>
	<acf7522a-4fc0-5138-9797-6cfcc5ad5719@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <acf7522a-4fc0-5138-9797-6cfcc5ad5719@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] configure: Enable out-of-tree
 acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>, qemu-devel@nongnu.org

On Tue, Jun 05, 2018 at 11:45:03AM -0300, Philippe Mathieu-Daud=E9 wrote:
[... something about config files ...]
> > And after that, the following would run all "console" tests:
> >=20
> >   avocado run -t console
> >=20
> > How does this sound?
>=20
> For my use cases this doesn't worry me, I'll let Eduardo/Fam opine abou=
t
> use_test_dir_when_no_references_given.

Well, I can't give an opinion because I couldn't understand
what's the final goal here.

What exactly is missing in the current solution?  Why
"avocado run -t console ." wouldn't work?

--=20
Eduardo
