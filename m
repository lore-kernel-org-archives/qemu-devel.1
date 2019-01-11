Received: from eggs.gnu.org ([209.51.188.92]:43017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gi5Sn-0006xn-JP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gi5Sm-0004iy-AC
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:39:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gi5Sm-0004hm-2s
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:39:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so16898014wrr.0
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 14:39:37 -0800 (PST)
References: <154724210898.37.4367801081630939892@2d170d368aaa>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <834ad86b-27d1-ce01-91dc-a5c939061ce9@redhat.com>
Date: Fri, 11 Jan 2019 23:39:34 +0100
MIME-Version: 1.0
In-Reply-To: <154724210898.37.4367801081630939892@2d170d368aaa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] contrib/gitdm: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fam@euphon.net, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alex.bennee@linaro.org

On 1/11/19 10:28 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190111155555.8270-1-philmd@redhat.com/
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20190111155555.8270-1-philmd@redhat.com
> Type: series
> Subject: [Qemu-devel] [PATCH] contrib/gitdm: Fix a typo
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback --color=always base..

I suppose Paolo expected his PR to land to upgrade patchew, and patchew
is still processing from an old queue?

> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> c995f5f contrib/gitdm: Fix a typo
> 
> === OUTPUT BEGIN ===
> Unknown option: color
> Usage:
> 
>     checkpatch.pl [OPTION]... [FILE]...
>     checkpatch.pl [OPTION]... [GIT-REV-LIST]
> 
> Version: 0.31
> 
> Options:
>   -q, --quiet                quiet
>   --no-tree                  run without a kernel tree
>   --no-signoff               do not check for 'Signed-off-by' line
>   --patch                    treat FILE as patchfile
>   --branch                   treat args as GIT revision list
>   --emacs                    emacs compile window format
>   --terse                    one line per report
>   -f, --file                 treat FILE as regular source file
>   --strict                   fail if only warnings are found
>   --root=PATH                PATH to the kernel tree root
>   --no-summary               suppress the per-file summary
>   --mailback                 only produce a report in case of warnings/errors
>   --summary-file             include the filename in summary
>   --debug KEY=[0|1]          turn on/off debugging of KEY, where KEY is one of
>                              'values', 'possible', 'type', and 'attr' (default
>                              is all off)
>   --test-only=WORD           report only warnings/errors containing WORD
>                              literally
>   -h, --help, --version      display this help and exit
> 
> When FILE is - read standard input.
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20190111155555.8270-1-philmd@redhat.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 
