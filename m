Received: from eggs.gnu.org ([2001:4830:134:3::10]:33505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evHzW-0001VQ-IF
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 03:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evHzT-0004Q9-FY
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 03:35:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1evHzT-0004Pm-Al
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 03:35:27 -0400
References: <1520786414-8806-1-git-send-email-aishwaryakadlag@gmail.com>
	<6666720e-6f5c-0e8c-6c5a-ac36d708e314@redhat.com>
	<20180312070545.ktvvgp2kn2uxjpzk@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9c6ebbda-af49-64b1-6283-771c9a9bfac3@redhat.com>
Date: Mon, 12 Mar 2018 08:35:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180312070545.ktvvgp2kn2uxjpzk@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V1]sm501: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Aishwarya Kadlag <aishwaryakadlag@gmail.com>, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>

On 12.03.2018 08:05, Gerd Hoffmann wrote:
>   Hi,
>=20
>> I don't know the hw/display code very well, but I think it's not that
>> easy... Putting Gerd on CC:, maybe he can describe the details of that
>> BiteSizeTask a little bit better.
>=20
> [ Side note: Is there a wiki page for this? ]

There is an entry here:

https://wiki.qemu.org/BiteSizedTasks#Dead_code_removal

Sorry Gerd, I thought it was likely you who added that task, but seems
like this specific task has rather been added by Paolo back in 2014 alrea=
dy:

https://wiki.qemu.org/index.php?title=3DContribute/BiteSizedTasks&diff=3D=
4449&oldid=3D4444

 Thomas
