Received: from eggs.gnu.org ([2001:4830:134:3::10]:35734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUuan-0000hb-He
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUuam-0007Sp-Jv
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUuam-0007Se-Da
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:48:40 -0400
Date: Tue, 11 Jul 2017 14:48:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711144834.08db66a0@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170711004303.3902-3-ehabkost@redhat.com>
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] test-qdev-global-props: Test global
 property ordering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

On Mon, 10 Jul 2017 21:43:02 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Test case to detect the bug fixed by commit
> "qdev: fix the order compat and global properties are applied".
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/test-qdev-global-props.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
