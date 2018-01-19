Received: from eggs.gnu.org ([2001:4830:134:3::10]:48003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVV1-0005Pg-6i
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:10:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecVUy-00040I-1h
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:10:23 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180119103233.26075-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <216e835b-dcae-5ec3-20d6-a4da125a44d4@amsat.org>
Date: Fri, 19 Jan 2018 09:10:15 -0300
MIME-Version: 1.0
In-Reply-To: <20180119103233.26075-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] build: fix typo in error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org

On 01/19/2018 07:32 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index bc7224a27f..807ca0b4f8 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -28,7 +28,7 @@ error() {
>      echo
>      echo "and then manually update submodules prior to running make, with:"
>      echo
> -    echo " $ scripts/git-sbumodule.sh update $modules"
> +    echo " $ scripts/git-submodule.sh update $modules"
>      echo
>      exit 1
>  }
> 
