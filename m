Received: from eggs.gnu.org ([2001:4830:134:3::10]:56283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daLbZ-0006ms-Em
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daLbW-0004eA-3R
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:39:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1daLbV-0004dn-Ta
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:39:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBB947EA8B
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:39:52 +0000 (UTC)
Message-ID: <1501072789.29903.9.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 26 Jul 2017 14:39:49 +0200
In-Reply-To: <0edd3c83-ddcc-622d-5805-3e3a7788ad4d@redhat.com>
References: <20170726115637.21558-1-kraxel@redhat.com>
	<20170726115637.21558-5-kraxel@redhat.com>
	<0edd3c83-ddcc-622d-5805-3e3a7788ad4d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] ui: add multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>


> I wondered if this would work, but didn't mention anything on the
> assumption that it built for you.=C2=A0=C2=A0But now that patchew is
> complaining
> about a failed build, I suspect your attempt at abbreviation here is
> the
> reason.

It worked for me, but only because it didn't build the docs.

Installing texinfo now ...

cheers,
  Gerd
