Received: from eggs.gnu.org ([2001:4830:134:3::10]:56338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6cuw-0007Oj-OQ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6cut-00010P-4b
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:05:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6cus-00010D-US
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:05:03 -0400
Message-ID: <1493989500.371.92.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 05 May 2017 15:05:00 +0200
In-Reply-To: <20170505122019.23144-1-philippevoinov@gmail.com>
References: <20170505122019.23144-1-philippevoinov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] ui: input-linux: Add absolute event
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe Voinov <philippevoinov@gmail.com>
Cc: qemu-devel@nongnu.org

  Hi,

> This patch also refactors the ui/input.c to=20
> support absolute axis
> minimum values other than 0.

Can you put that into a separate patch please?

thanks,
  Gerd
