Received: from eggs.gnu.org ([2001:4830:134:3::10]:46697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fL5Fc-0004lF-Vz
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fL5FY-0002VU-3g
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:14:44 -0400
Date: Tue, 22 May 2018 13:14:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180522131435.0e06ca84.cohuck@redhat.com>
In-Reply-To: <20180522104000.9044-5-peter.maydell@linaro.org>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] ppc: Rename 2.13 machines to 3.0
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

On Tue, 22 May 2018 11:39:59 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Rename the 2.13 machines to match the number we're going to
> use for the next release.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/ppc/cpu.h                |  2 +-
>  hw/ppc/spapr.c                  | 14 +++++++-------
>  target/ppc/machine.c            |  8 ++++----
>  target/ppc/translate_init.inc.c |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
