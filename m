Received: from eggs.gnu.org ([2001:4830:134:3::10]:36807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f6yRX-0001Fe-W4
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f6yRU-0007BV-Lh
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:08:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f6yRU-0007AU-H7
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:08:40 -0400
Date: Fri, 13 Apr 2018 15:08:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180413130831.4couuearzgz6f77s@sirius.home.kraxel.org>
References: <20180410120222.31845-1-tournier.elie@gmail.com>
	<20180410120222.31845-2-tournier.elie@gmail.com>
	<c6e49f50-0cd0-c118-f080-48751de595ec@redhat.com>
	<20180410133335.zzvgg7lqe2lb2zdx@sirius.home.kraxel.org>
	<20180412141153.GA16814@Nikki.localdomain>
	<20180413061529.ulu6jxmcs4mgfmdc@sirius.home.kraxel.org>
	<20180413101646.GA6099@Nikki.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413101646.GA6099@Nikki.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 1/2 for-2.12?] qapi: Parameter gl of
 DisplayType now accept an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elie Tournier <tournier.elie@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, Elie Tournier <elie.tournier@collabora.com>

> > No need to hurry with this.  QMP doesn't see the structs, so no
> > compatibility problem here.  gl=on cmd line option was present in 2.11 +
> > older already, so that must continue to work no matter whenever this
> > makes 2.12 or not.
> 
> Alright, thanks.
> Well, to be fair, I just want to see this feature upstream, I don't really care
> about the release number.
> 
> Just a question before I resend the series.
> Should I note "Since 2.12" or "Since 2.13" in qapi/ui.json?

2.13 please.

thanks,
  Gerd
