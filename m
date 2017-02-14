Received: from eggs.gnu.org ([2001:4830:134:3::10]:41824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdcN9-00062E-Qx
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdcN5-0001Eb-66
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:38:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdcN5-0001Dn-09
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:38:15 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA-gQDCVK6hZ9X7B6YUxr_icsew=AUBiEW3OaxzsqbA0ww@mail.gmail.com>
	(Peter Maydell's message of "Tue, 14 Feb 2017 09:55:31 +0000")
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<CAFEAcA-gQDCVK6hZ9X7B6YUxr_icsew=AUBiEW3OaxzsqbA0ww@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 14 Feb 2017 13:38:03 +0100
Message-ID: <87a89p3q38.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/12] Multifd v4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 13 February 2017 at 17:19, Juan Quintela <quintela@redhat.com> wrote:
>> Hi
>>
>> [v4]
>>
>> - Address reviews
>> - move synchronization to semaphores (faster).  Paolo suggestion
>> - improvements overall (see invidiual patches)
>> - fix all the checkpatch warnings
>> - fix all [HACKS] except for one
>> Please review.
>
>
> Is this a patch series or a pull request? The subject line
> says "PATCH" and the body says 'please review' but it's in
> the form of a pull request email...

patch, sorry.

I have to upgrade my scripts.

Sorry again, Juan.
