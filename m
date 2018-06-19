Received: from eggs.gnu.org ([2001:4830:134:3::10]:33248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9al-00051p-PT
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9ai-0004DJ-Nv
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:54:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fV9ai-0004D8-IQ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:54:08 -0400
Date: Tue, 19 Jun 2018 13:53:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180619055348.GI16790@xz-mi>
References: <20180619053426.13065-1-peterx@redhat.com>
	<20180619053426.13065-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180619053426.13065-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/7] monitor: flush qmp responses when
 CLOSED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 19, 2018 at 01:34:22PM +0800, Peter Xu wrote:

[...]

> Fixes: 6d2d563f8c ("qmp: cleanup qmp queues properly", 2018-03-27)
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

I am pretty sure this time that this 2nd line is not there in my local
tree. :)

I think it's a git-format-patch bug, otherwise I must have misused it
for a long time.  Instead of figuring this out and repost again, I'll
see how far the rest of the series can go.

Regards,

-- 
Peter Xu
