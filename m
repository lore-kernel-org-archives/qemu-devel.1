Received: from eggs.gnu.org ([2001:4830:134:3::10]:38956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpu9a-000818-8d
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpu9W-0003gW-TS
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:39:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpu9W-0003fI-Gr
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:39:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180815095328.32414-1-peterx@redhat.com>
Date: Wed, 15 Aug 2018 13:39:43 +0200
In-Reply-To: <20180815095328.32414-1-peterx@redhat.com> (Peter Xu's message of
	"Wed, 15 Aug 2018 17:53:25 +0800")
Message-ID: <87va8bluyo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 0/3] error-report: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Halil Pasic <pasic@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>

An ACK from Michael Tsirkin would be nice.  But silence won't keep this
series out for long.
