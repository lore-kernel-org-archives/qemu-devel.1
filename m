Received: from eggs.gnu.org ([2001:4830:134:3::10]:57650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gM9nP-0007yc-Uu
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gM9nO-0002IW-2g
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:50:19 -0500
Date: Mon, 12 Nov 2018 11:49:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181112104953.GB11580@linux.fritz.box>
References: <20181109221213.7310-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109221213.7310-1-crosa@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Am 09.11.2018 um 23:12 hat Cleber Rosa geschrieben:
> The initial goal of this RFC is to get feedback on tests not specific
> to the QEMU main binary, but specific to other components such as
> qemu-img.
> 
> For this experiment, a small issue with the zero and negative number
> of I/O operations given to the bench command was chosen.

Any reason why this shouldn't be in qemu-iotests?

Kevin
