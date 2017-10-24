Received: from eggs.gnu.org ([2001:4830:134:3::10]:44196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6yJW-0003A0-PN
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6yJT-0001bp-Ky
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:28:10 -0400
Date: Tue, 24 Oct 2017 14:20:32 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171024122032.GF18756@stefanha-x1.localdomain>
References: <20171020091403.1479-1-berrange@redhat.com>
	<20171024074324.GB24198@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171024074324.GB24198@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] ide: avoid referencing NULL
 dev in rotational rate setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

On Tue, Oct 24, 2017 at 08:43:24AM +0100, Daniel P. Berrange wrote:
> CC John

Feel free to ping me if John doesn't respond by next Wednesday and I'll
merge this trivial fix.

Stefan
