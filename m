Received: from eggs.gnu.org ([2001:4830:134:3::10]:60969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fV9Ym-00048L-UO
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fV9Yj-0003P1-UZ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:52:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fV9Yj-0003N0-L4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:52:05 -0400
References: <20180619053426.13065-1-peterx@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <92641a09-a750-e4bd-bb88-d022e4c0591f@redhat.com>
Date: Tue, 19 Jun 2018 07:51:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180619053426.13065-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/7] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 19.06.2018 07:34, Peter Xu wrote:
> v4:
> - collect some r-bs
> - remove one extra s-o-b of mine in one patch [Thomas, Markus]

FYI: You've still got a duplicated s-o-b line in patch 3 and 4.

 Thomas
