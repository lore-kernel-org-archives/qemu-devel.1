Received: from eggs.gnu.org ([209.51.188.92]:45562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk76L-00054O-6A
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk76J-0001c1-EQ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:48:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gk76J-0001ab-8c
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:48:51 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
	<20190117073747.5399.79626.stgit@pasha-VirtualBox>
Date: Thu, 17 Jan 2019 13:48:18 +0100
In-Reply-To: <20190117073747.5399.79626.stgit@pasha-VirtualBox> (Pavel
	Dovgalyuk's message of "Thu, 17 Jan 2019 10:37:47 +0300")
Message-ID: <8736pr4fhp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 10/24] qapi: introduce replay.json for
 record/replay-related stuff
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

Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> This patch adds replay.json file. It will be
> used for adding record/replay-related data structures and commands.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
