Received: from eggs.gnu.org ([2001:4830:134:3::10]:58700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fImCl-0004fi-14
	for qemu-devel@nongnu.org; Tue, 15 May 2018 22:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fImCg-0006nI-6d
	for qemu-devel@nongnu.org; Tue, 15 May 2018 22:30:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36490 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fImCg-0006kt-1k
	for qemu-devel@nongnu.org; Tue, 15 May 2018 22:30:10 -0400
Date: Wed, 16 May 2018 10:30:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180516023003.GD6731@lemon.usersys.redhat.com>
References: <20180504074207.22634-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504074207.22634-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/4] slirp: Add query-usernet QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, berrange@redhat.com, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Fri, 05/04 15:42, Fam Zheng wrote:
> v6: Rename QAPI enum: TCPS -> UsernetTcpState. [Daniel]

Ping?

Fam
