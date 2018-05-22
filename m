Received: from eggs.gnu.org ([2001:4830:134:3::10]:46028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fL5Cz-0003F9-Fk
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fL5Cu-0001Xd-Il
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:12:01 -0400
Date: Tue, 22 May 2018 13:11:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180522131149.13326045.cohuck@redhat.com>
In-Reply-To: <20180522104000.9044-3-peter.maydell@linaro.org>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/i386: Rename 2.13 machine types to
 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Tue, 22 May 2018 11:39:57 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Rename the 2.13 machine types to match what we're going to
> use as our next release number.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/i386/pc_piix.c | 8 ++++----
>  hw/i386/pc_q35.c  | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
