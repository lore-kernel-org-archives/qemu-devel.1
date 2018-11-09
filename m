Received: from eggs.gnu.org ([2001:4830:134:3::10]:41846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gL9sm-00041i-ST
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gL9sa-0007IZ-Vz
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:43:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gL9sa-0007GY-OE
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:43:32 -0500
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-5-crosa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73dc7758-0627-e840-9be0-2b6bf68d0b35@redhat.com>
Date: Fri, 9 Nov 2018 10:43:10 -0600
MIME-Version: 1.0
In-Reply-To: <20181109150710.31085-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] check-help: visual and content
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/9/18 9:07 AM, Cleber Rosa wrote:
> The "check" target is not a target that will run all other tests
> listed, so in order to be accurate it's necessary to list those that
> will run.  The same is true for "check-clean".
> 
> Then, to give a better visual impression of the differences in the
> various targets, let's add empty lines.
> 
> Finally, a small (and hopeful) grammar fix from a non-native speaker.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/Makefile.include | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
