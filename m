Received: from eggs.gnu.org ([2001:4830:134:3::10]:35845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2vnI-00070K-Fy
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2vnE-0003bE-KT
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:58:12 -0400
References: <20171013085355.7563-1-famz@redhat.com>
	<20171013085355.7563-4-famz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <94fd9fb1-e99b-0afe-ec36-833c59e97d0d@redhat.com>
Date: Fri, 13 Oct 2017 10:57:51 +0200
MIME-Version: 1.0
In-Reply-To: <20171013085355.7563-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] MAINTAINERS: Track
 default-configs/pci.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 13.10.2017 10:53, Fam Zheng wrote:
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3938ccbf8a..7cb237babc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -934,6 +934,7 @@ F: hw/pci/*
>  F: hw/pci-bridge/*
>  F: docs/pci*
>  F: docs/specs/*pci*
> +F: default-configs/pci.mak
>  
>  ACPI/SMBIOS
>  M: Michael S. Tsirkin <mst@redhat.com>
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
