Received: from eggs.gnu.org ([209.51.188.92]:44482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghGhW-0007qF-SP
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghGhV-0006id-1O
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:27:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghGhT-0006hs-CA
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:27:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
	<154703593161.13472.3217514062253486720.stgit@pasha-VirtualBox>
Date: Wed, 09 Jan 2019 17:27:11 +0100
In-Reply-To: <154703593161.13472.3217514062253486720.stgit@pasha-VirtualBox>
	(Pavel Dovgalyuk's message of "Wed, 09 Jan 2019 15:12:11 +0300")
Message-ID: <87h8ehbxuo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 09/21] replay: provide and accessor for
 rr filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

In the subject: "an accessor".
