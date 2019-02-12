Received: from eggs.gnu.org ([209.51.188.92]:36626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtSSE-0006M0-SH
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtSHR-0003GH-8H
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:14:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gtSHQ-0003F3-VT
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:14:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154935478086.7509.4349987292919289245.stgit@pasha-VirtualBox>
	<002301d4c207$27d88d50$7789a7f0$@ru>
Date: Tue, 12 Feb 2019 08:14:49 +0100
In-Reply-To: <002301d4c207$27d88d50$7789a7f0$@ru> (Pavel Dovgalyuk's message
	of "Mon, 11 Feb 2019 15:41:47 +0300")
Message-ID: <87y36lpjfa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 00/25] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

"Pavel Dovgalyuk" <dovgaluk@ispras.ru> writes:

> Ping?

Are you pinging for more review, or for someone to merge this?
